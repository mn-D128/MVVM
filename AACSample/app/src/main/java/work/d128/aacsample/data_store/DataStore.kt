package work.d128.aacsample.data_store

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import work.d128.aacsample.entity.search_response.SearchResponse
import com.google.gson.GsonBuilder
import okhttp3.logging.HttpLoggingInterceptor
import okhttp3.OkHttpClient

object DataStore {
    private val service: ApiService by lazy {
        val interceptor = HttpLoggingInterceptor()
        interceptor.level = HttpLoggingInterceptor.Level.NONE
        val client = OkHttpClient.Builder()
            .addInterceptor(interceptor)
            .build()

        val gsonBuilder = GsonBuilder()
        gsonBuilder.setLenient()
        val gson = gsonBuilder.create()

        val retrofit = Retrofit.Builder()
            .baseUrl("https://ja.wikipedia.org/")
            .client(client)
            .addConverterFactory(GsonConverterFactory.create(gson))
            .build()
        retrofit.create(ApiService::class.java)
    }

    suspend fun search(srsearch: String): SearchResponse {
        val query = mapOf(
            "format" to "json",
            "action" to "query",
            "list" to "search",
            "srsearch" to srsearch,
        )
        return service.api(query)
    }
}
