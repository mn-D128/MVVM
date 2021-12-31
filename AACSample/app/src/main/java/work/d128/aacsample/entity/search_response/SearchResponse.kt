package work.d128.aacsample.entity.search_response

import kotlinx.serialization.Serializable

@Serializable
data class SearchResponse(
    val query: Query
)
