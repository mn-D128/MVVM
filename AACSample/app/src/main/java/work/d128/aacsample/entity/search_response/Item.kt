package work.d128.aacsample.entity.search_response

import kotlinx.serialization.*

@Serializable
data class Item (
    val ns: Int,
    val title: String,
    val pageid: Int,
    val size: Int,
    val wordcount: Int,
    val snippet: String,
    val timestamp: String
)
