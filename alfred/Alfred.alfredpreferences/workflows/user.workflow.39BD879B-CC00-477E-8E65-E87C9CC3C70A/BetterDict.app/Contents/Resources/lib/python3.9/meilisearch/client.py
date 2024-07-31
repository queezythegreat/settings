from meilisearch.index import Index
from meilisearch.config import Config
from meilisearch._httprequests import HttpRequests
from meilisearch.errors import MeiliSearchApiError

class Client():
    """
    A client for the MeiliSearch API

    A client instance is needed for every MeiliSearch API method to know the location of
    MeiliSearch and its permissions.
    """

    config = None
    http = None

    def __init__(self, url, apiKey=None):
        """
        Parameters
        ----------
        url : str
            The url to the MeiliSearch API (ex: http://localhost:7700)
        apiKey : str
            The optional API key for MeiliSearch
        """
        self.config = Config(url, apiKey)
        self.http = HttpRequests(self.config)

    def create_index(self, uid, options=None):
        """Create an index.

        If the argument `uid` isn't passed in, it will be generated
        by MeiliSearch.

        Parameters
        ----------
        uid: str
            UID of the index
        options: dict, optional
            Options passed during index creation (ex: primaryKey)

        Returns
        -------
        index : Index
            an instance of Index containing the information of the newly created index
        Raises
        ------
        HTTPError
            In case of any other error found here https://docs.meilisearch.com/references/#errors-status-code
        """
        index = Index(self.config, uid)
        index.create(self.config, uid, options)
        return index

    def get_indexes(self):
        """Get all indexes.

        Raises
        ------
        HTTPError
            In case of any error found here https://docs.meilisearch.com/references/#errors-status-code
        Returns
        -------
        list
            List of indexes in dictionnary format. (e.g [{ 'uid': 'movies' 'primaryKey': 'objectID' }])
        """
        return Index.get_indexes(self.config)


    def get_index(self, uid):
        """Get an index.

        Raises
        ------
        HTTPError
            In case of any error found here https://docs.meilisearch.com/references/#errors-status-code
        Returns
        -------
        index : Index
            an instance of Index containing the information of the index found
        """
        return Index.get_index(self.config, uid=uid)

    def get_or_create_index(self, uid, options=None):
        """Get an index, or create it if it doesn't exist.

        Parameters
        ----------
        uid: str
            UID of the index
        options: dict, optional
            Options passed during index creation (ex: primaryKey)

        Returns
        -------
        index : Index
            an instance of Index containing the information of the retrieved or newly created index
        Raises
        ------
        HTTPError
            In case of any other error found here https://docs.meilisearch.com/references/#errors-status-code
        """
        index = self.get_index(uid)
        try:
            index.create(self.config, uid, options)
        except MeiliSearchApiError as err:
            if err.error_code != 'index_already_exists':
                raise err
        return index

    def get_all_stats(self):
        """Get all stats of MeiliSearch

        Get information about database size and all indexes
        https://docs.meilisearch.com/references/stats.html
        Returns
        ----------
        stats: `dict`
            Dictionnary containing stats about your MeiliSearch instance
        """
        return self.http.get(self.config.paths.stat)

    def health(self):
        """Get health of MeiliSearch

        `204` HTTP status response when MeiliSearch is healthy.

        Raises
        ----------
        HTTPError
            If MeiliSearch is not healthy
        """
        return self.http.get(self.config.paths.health)

    def get_keys(self):
        """Get all keys created

        Get list of all the keys that were created and all their related information.

        Returns
        ----------
        keys: list
            List of keys and their information.
            https://docs.meilisearch.com/references/keys.html#get-keys
        """
        return self.http.get(self.config.paths.keys)

    def get_version(self):
        """Get version MeiliSearch

        Returns
        ----------
        version: dict
            Information about the version of MeiliSearch.
        """
        return self.http.get(self.config.paths.version)

    def version(self):
        """Alias for get_version

        Returns
        ----------
        version: dict
            Information about the version of MeiliSearch.
        """
        return self.get_version()

    def create_dump(self):
        """Triggers the creation of a MeiliSearch dump

        Returns
        ----------
        Dump: dict
            Information about the dump.
            https://docs.meilisearch.com/references/dump.html#create-a-dump
        """
        return self.http.post(self.config.paths.dumps)

    def get_dump_status(self, uid):
        """Retrieves the status of a MeiliSearch dump creation

        Parameters
        ----------
        uid: str
            UID of the dump

        Returns
        ----------
        Dump status: dict
            Information about the dump status.
            https://docs.meilisearch.com/references/dump.html#get-dump-status
        """
        return self.http.get(
            self.config.paths.dumps + '/' + str(uid) + '/status'
        )
