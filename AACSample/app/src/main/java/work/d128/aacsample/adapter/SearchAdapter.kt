package work.d128.aacsample.adapter

import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import work.d128.aacsample.databinding.RowItemSearchBinding
import work.d128.aacsample.model.SearchResultItemModel

class SearchAdapter : RecyclerView.Adapter<SearchAdapter.ViewHolder>() {

    private var dataSet = listOf<SearchResultItemModel>()
    private var selectedItemListener: OnSelectedItemListener? = null

    class ViewHolder(val binding: RowItemSearchBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(viewGroup: ViewGroup, viewType: Int): ViewHolder {
        val inflate = LayoutInflater.from(viewGroup.context)
        val binding = RowItemSearchBinding.inflate(inflate, viewGroup, false)
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(viewHolder: ViewHolder, position: Int) {
        viewHolder.binding.model = this.dataSet[position]
        viewHolder.binding.root.setOnClickListener {
            selectedItemListener?.onSelectedItem(position)
        }
    }

    override fun getItemCount() = dataSet.size

    @SuppressLint("NotifyDataSetChanged")
    fun setDataSet(dataSet: List<SearchResultItemModel>) {
        this.dataSet = dataSet
        this.notifyDataSetChanged()
    }

    fun setOnSelectedItemListener(listener: OnSelectedItemListener) {
        this.selectedItemListener = listener
    }

    interface OnSelectedItemListener {
        fun onSelectedItem(position: Int)
    }
}