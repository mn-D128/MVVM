package work.d128.aacsample.model

import android.os.Parcelable
import kotlinx.parcelize.IgnoredOnParcel
import kotlinx.parcelize.Parcelize

@Parcelize
class DetailModel(private val pageId: Int, val title: String) : Parcelable {
    @IgnoredOnParcel
    val url = "https://ja.wikipedia.org/?curid=" + this.pageId
}