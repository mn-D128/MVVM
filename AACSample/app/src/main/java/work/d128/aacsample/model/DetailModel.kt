package work.d128.aacsample.model

import android.os.Parcelable
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize
import work.d128.aacsample.value_object.PageId

@Parcelize
class DetailModel(private val pageId: PageId, val title: String) : Parcelable {
    @IgnoredOnParcel
    val url = "https://ja.wikipedia.org/?curid=" + this.pageId
}