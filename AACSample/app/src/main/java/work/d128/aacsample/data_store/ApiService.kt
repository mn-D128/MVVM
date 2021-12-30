package work.d128.aacsample.data_store

import retrofit2.http.GET
import retrofit2.http.QueryMap
import work.d128.aacsample.entity.search_response.SearchResponse

interface ApiService {
    @GET("w/api.php")
    suspend fun api(
        @QueryMap options: Map<String, String>
    ): SearchResponse
}
