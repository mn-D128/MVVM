package work.d128.aacsample.repository

import work.d128.aacsample.data_store.DataStore
import work.d128.aacsample.entity.search_response.SearchResponse

class Repository {
    suspend fun search(search: String): SearchResponse = DataStore.search(search)
}