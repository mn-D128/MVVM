package work.d128.aacsample.model

import work.d128.aacsample.entity.search_response.Item

class SearchResultItemModel(item: Item) {
    val title: String
    val pageId: Int

    init {
        this.title = item.title
        this.pageId = item.pageid
    }
}