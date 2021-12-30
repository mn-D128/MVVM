package work.d128.aacsample.model

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
class DetailModel(private val pageId: Int, val title: String): Parcelable {
    val url = "https://ja.wikipedia.org/?curid=" + this.pageId
}