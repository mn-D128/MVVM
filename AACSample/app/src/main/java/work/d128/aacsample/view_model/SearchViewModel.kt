package work.d128.aacsample.view_model

import android.app.Application
import android.view.View
import android.widget.SearchView
import android.widget.Toast
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import work.d128.aacsample.adapter.SearchAdapter
import work.d128.aacsample.model.DetailModel
import work.d128.aacsample.model.SearchResultItemModel
import work.d128.aacsample.repository.Repository

class SearchViewModel(application: Application): AndroidViewModel(application) {
    private val repository = Repository()
    private var dataSet = listOf<SearchResultItemModel>()

    val adapter by lazy {
        SearchAdapter().apply {
            this.setOnSelectedItemListener(selectedItemListener)
        }
    }

    val searchViewQueryTextListener by lazy {
        object: SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String): Boolean {
                _progressBarVisibility.value = View.VISIBLE

                viewModelScope.launch {
                    runCatching {
                        repository.search(query)
                    }.fold(
                        onSuccess = { response ->
                            dataSet = response.query.search.map { SearchResultItemModel(it) }
                            adapter.setDataSet(dataSet)
                        },
                        onFailure = {
                            val text = it.localizedMessage ?: "通信に失敗しました"
                            Toast.makeText(application, text, Toast.LENGTH_SHORT).show()
                        }
                    ).also {
                        _progressBarVisibility.value = View.INVISIBLE
                    }
                }
                return false
            }

            override fun onQueryTextChange(newText: String): Boolean {
                return false
            }
        }
    }

    private val _progressBarVisibility = MutableStateFlow(View.INVISIBLE)
    val progressBarVisibility = this._progressBarVisibility.asStateFlow()

    private val _showDetail = MutableSharedFlow<DetailModel>()
    val showDetail = this._showDetail.asSharedFlow()

    private val selectedItemListener by lazy {
        object: SearchAdapter.OnSelectedItemListener {
            override fun onSelectedItem(position: Int) {
                val item = dataSet[position]
                val model = DetailModel(item.pageId, item.title)

                viewModelScope.launch {
                    _showDetail.emit(model)
                }
            }
        }
    }
}