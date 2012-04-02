# File: ProjectTag/ProjectTag.py
# Version: 0.1.10

# imports {{{1
import ConfigParser
import os
import re
import shutil
import subprocess
import sys
import tempfile
import threading
import vim

# varibles {{{1
default_project_name = ''
tag_thread = None


def search_for_file_upper( cur_dir, file_name ): #{{{1
# search for the file from current directory to upper dir until meet the root
# directory, return the file's absolute path if found, or return None if not
# found

    cur_dir_local = os.path.abspath( cur_dir )
    
    while True:
        cur_check = cur_dir_local + os.path.sep + file_name
        # if cur path meets the condition, then return the path
        if os.path.isfile( cur_check ): 
            return cur_check

        # if condition does not meet, go upper
        upper_cur_dir_local = os.path.dirname( cur_dir_local )

        # if this is the root directory, then return None
        if upper_cur_dir_local == cur_dir_local: 
            return None

        cur_dir_local = upper_cur_dir_local



def get_included_files( filelines ): #{{{1
# get include files (#include <somefile> or #include "somefile")
# from a list of file lines

    ret = set()

    rematch = re.compile( r'#[ \t]*include[ \t]*[<"][^<>"]+[>"]' )
    refind = re.compile( r'(?<=[<"])[^<>"]+(?=[>"])' )

    for line in filelines:
        trimmed_line = line.strip()
        rem = rematch.match( trimmed_line )

        if rem == None:
            continue

        rem = refind.search( trimmed_line )
        if rem == None:
            continue

        ret.add( rem.group( 0 ) )

    return ret

def __get_included_files_reclusively( src, include_dirs, checked_files ):#{{{1
# get the included file of a c/c++ source file and it's included file(internal
# use)

    # if current file has been checked, return an empty set
    if src in checked_files:
        return set()

    # set current file as checked
    checked_files.add( src )

    try:
        f = open( src, 'r' )
    except IOError, message:
        print >> sys.stderr, "ProjectTag: Can not open file "+src, message
        return set()

    ret = set()

    # get the included file paths
    header_files = get_included_files( f.readlines() )

    # add the directory where the source file locates to include directory
    # list
    include_dirs2 = include_dirs[:]
    include_dirs2.append( os.path.dirname( src ) )
    for include_dir in include_dirs2:
        for header_file in header_files:

            # the path of new file
            file_path = include_dir + os.path.sep + header_file 

            # make the file path seperator be consitent with the os'
            if os.path.sep == '/':
                file_path = file_path.replace( '\\','/' )
            else:
                file_path = file_path.replace( '/','\\' )

            # if the file exists, then add this file to ret
            if os.path.isfile( file_path ) :
                ret.add( file_path )
                ret |= __get_included_files_reclusively( file_path,
                        include_dirs, checked_files )

    return ret

def get_included_files_reclusively( src, include_dirs ): #{{{1
# get the included file of a c/c++ source file and it's included file

    return __get_included_files_reclusively( src, include_dirs, set() )



def generate_tags_ctags( file_set, outfile, flags, #{{{1
        tag_prog_cmd='ctags' ):
# generate tags from file_set, write the result to outfile
# params: 
# file_set: file to generate tags for
# outfile: the output file
# tag_prog_cmd: command to call the tag program, such as /usr/bin/ctags, etc
# flags: tag generation flags

    file_list = ''
    for fi in file_set:
        file_list += fi
        file_list += '\n'

    # create ctags process, which reads file names from stdin
    sp = subprocess.Popen( tag_prog_cmd + ' -L - ' + flags + ' -f '+ outfile,
            shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
            stderr = subprocess.PIPE )

    # put the file names to stdin of ctags
    sp.communicate( input = file_list )

    # wait the process to terminate
    while sp.returncode == None:
        pass

    return sp.returncode

class ProjectConfig( ConfigParser.ConfigParser ):#{{{1
# the config parser for project ini file

    # the directory where the project file locates
    project_dir = None

    def does_config_file_exist( self ):#{{{2
        return self.project_dir != None

    def __init__( self, project_file_name ):#{{{2
    # init, the argument project_file_name is the name of project file, not
    # the full path. the function will search upper to find this file

        ConfigParser.ConfigParser.__init__( self )

        project_file_path = search_for_file_upper(
                vim.eval( "expand('%:p:h')" ), project_file_name )
        if project_file_path == None:
            return

        self.project_dir = os.path.dirname( project_file_path )

        self.read( project_file_path )
        self.set_project_config_parser_default_value()


    def generate_tags( self ):#{{{2
    # generate tags

        # do nothing if config file does not exist
        if not self.does_config_file_exist():
            return

        tagoutput = self.get( 'general', 'tagoutput' )
        tagoutput = self.project_dir + os.path.sep + tagoutput
        tagflag = self.get( 'general', 'tagflag' )
        tagprog = self.get( 'general', 'tagprog' )
        temp_tagoutput = tagoutput + '.tmp'
        file_set = self.get_files_to_tag()

        # generate tag file and check the return code of ctags
        ctags_returncode = generate_tags_ctags( file_set, temp_tagoutput, 
                tagflag, tagprog )
        if  ctags_returncode != 0:
            print >> sys.stderr, \
                    "ProjectTag: Ctags' return code is not zero, but " +\
                    str( ctags_returncode ) + "."
            return False
        
        if os.path.isfile( tagoutput ):
            try:
                os.remove( tagoutput )
            except OSError, message:
                print >> sys.stderr, 'Can not delete '+tagoutput, message
                return False

        try:
            shutil.move( temp_tagoutput, tagoutput )
        except IOError, message:
            print >> sys.stderr, 'ProjectTag: Cannot move file "' + \
                    temp_tagoutput + '" to "' + tagoutput + '" ', message

        return True
        

    # set the option to default value if the user does not set it
    def __set_option_if_not_have( self, section, option, defaultval ):#{{{2
        if not self.has_section( section ):
            self.add_section( section )

        if not self.has_option( section, option ):
            self.set( section, option, defaultval )

        return

    def add_tag_file( self ):#{{{2
    # find the tags output file and add it to tags

        # do nothing if config file does not exist
        if not self.does_config_file_exist():
            return

        tagoutput = self.get( 'general', 'tagoutput' ).strip()
        tag_path = self.project_dir + os.path.sep + tagoutput
        vim.command( "setlocal tags+=" + 
                vim.eval( r"escape('" + tag_path + r"', '\ |')" ) )


    def set_project_config_parser_default_value( self ):#{{{2
        self.__set_option_if_not_have( 'general','include_dirs','' )
        self.__set_option_if_not_have( 'general','sources','' )
        self.__set_option_if_not_have( 'general','tagprog','ctags' )
        self.__set_option_if_not_have( 'general','tagflag','--c-kinds=+px\
                --c++-kinds=+px' )
        self.__set_option_if_not_have( 'general','tagoutput','tags.prom' )
        self.__set_option_if_not_have( 'general','auto_timeout','0' )
        
    def get_files_to_tag( self ):#{{{2
    # return a list of files to tag

        # do nothing if config file does not exist
        if not self.does_config_file_exist():
            return

        # Get the sources and include directories. Replace those slashes or
        # backslashes to the os' path seperator.
        sources = [s.strip().replace( '\\/', os.path.sep ) for s in self.get(
            'general','sources' ).split( ',' )]
        include_dirs = [s.strip().replace( '\\/', os.path.sep ) for s in
                self.get( 'general','include_dirs' ).split( ',' )]
        ret = set()

        # the full path of sources
        sources_full_path = [ self.project_dir + os.path.sep
                + s for s in sources ]

        sources_full_path = filter( os.path.isfile, sources_full_path )

        # first add the sources
        ret |= set( sources_full_path )

        # now it's time to get the path of all included headers
        for src in sources_full_path:
            # if it's not a C/C++ source file, then skip
            if re.match( r'.*\.(c|C|cpp|cxx|cc|c\+\+)', src ) == None:
                continue

            ret |= get_included_files_reclusively( src, include_dirs )

        return ret


# called by s:GenerateProjectTags( back_ground )
def generate_pro_tags( back_ground ):#{{{1

    global tag_thread
    global default_project_name

    pc = ProjectConfig( default_project_name )

    # if the config file does not exist, return immediately
    if not pc.does_config_file_exist():
        vim.command( 'echohl ErrorMsg |\
                echo "ProjectTag: Project file not found!" | echohl None' )
        pc = None
        return

    if tag_thread != None and tag_thread.isAlive():
        pc = None
        return

    tag_thread = threading.Thread( target=ProjectConfig.generate_tags,
            args=(pc,) )
    tag_thread.daemon = True
    # if the tag generating thread fails to start, then show an error message
    # and return
    try:
        tag_thread.start()
    except RuntimeError:
        vim.command( 'echohl ErrorMsg |\
                echo "ProjectTag: Failed to start the tag generating thread!"\
                | echohl None' )
        pc = None
        return


    # if run foreground
    if back_ground == 0:

        tag_thread.join()

    # after generating the tag, add the tag file to tags
    pc.add_tag_file()

    pc = None


#}}}

# vim: fdm=marker et ts=4 sw=4 tw=78 fdc=3

