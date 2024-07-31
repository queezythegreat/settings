import pytest
import meilisearch
from meilisearch.errors import MeiliSearchApiError
from meilisearch.tests import BASE_URL, MASTER_KEY

class TestMeiliSearchApiError:

    """ TESTS: MeiliSearchApiError class """

    @staticmethod
    def test_meilisearch_api_error_no_master_key():
        client = meilisearch.Client(BASE_URL)
        with pytest.raises(MeiliSearchApiError):
            client.create_index("some_index")

    @staticmethod
    def test_meilisearch_api_error_wrong_master_key():
        client = meilisearch.Client(BASE_URL, MASTER_KEY + '123')
        with pytest.raises(MeiliSearchApiError):
            client.create_index("some_index")
