package work.d128.aacsample.model

import work.d128.aacsample.entity.search_response.Item

class SearchResultItemModel(item: Item) {
    val title = item.title
    val pageId = item.pageid
}