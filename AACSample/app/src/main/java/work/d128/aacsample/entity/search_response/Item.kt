package work.d128.aacsample.entity.search_response

import work.d128.aacsample.value_object.PageId

data class Item(
    val ns: Int,
    val title: String,
    val pageid: PageId,
    val size: Int,
    val wordcount: Int,
    val snippet: String,
    val timestamp: String
)
