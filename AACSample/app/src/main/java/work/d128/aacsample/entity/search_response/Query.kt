package work.d128.aacsample.entity.search_response

import kotlinx.serialization.Serializable

@Serializable
data class Query(
    val search: List<Item>
)
