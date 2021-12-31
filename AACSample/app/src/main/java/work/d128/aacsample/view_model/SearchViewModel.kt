package work.d128.aacsample.view_model

import android.app.Application
import android.view.View
import android.widget.SearchView
import android.widget.Toast
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import work.d128.aacsample.adapter.SearchAdapter
import work.d128.aacsample.model.DetailModel
import work.d128.aacsample.model.SearchResultItemModel
import work.d128.aacsample.repository.Repository
import java.util.concurrent.CancellationException

class SearchViewModel(application: Application, private val handle: SavedStateHandle) :
    AndroidViewModel(application) {
    private val repository = Repository()
    private var dataSet: List<SearchResultItemModel>? = null
    private var searchJob: Job? = null
    var searchViewQuery = handle.get(SAVED_STATE_HANDLE_KEY_SEARCH_VIEW_QUERY) ?: ""
        private set

    val adapter by lazy {
        SearchAdapter().apply {
            setOnSelectedItemListener(selectedItemListener)
        }
    }

    val searchViewQueryTextListener by lazy {
        object : SearchView.OnQueryTextListener {
            override fun onQueryTextSubmit(query: String): Boolean {
                if (searchViewQuery == query && dataSet != null) {
                    return false
                }

                searchViewQuery = query
                handle.set(SAVED_STATE_HANDLE_KEY_SEARCH_VIEW_QUERY, query)

                viewModelScope.launch {
                    if (searchJob?.isCompleted == false && searchJob?.isCancelled == false) {
                        searchJob?.cancelAndJoin()
                    }
                }

                searchJob = viewModelScope.launch {
                    _searchViewClearFocus.emit(Unit)
                    _progressBarContainerVisibility.value = View.VISIBLE

                    runCatching {
                        repository.search(query)
                    }.fold(
                        onSuccess = { response ->
                            val dataSet = response.query.search.map { SearchResultItemModel(it) }
                            this@SearchViewModel.dataSet = dataSet
                            adapter.setDataSet(dataSet)
                        },
                        onFailure = {
                            if (it::class.java.superclass == CancellationException::class.java) {
                                return@fold
                            }

                            val text = it.localizedMessage ?: "通信に失敗しました"
                            Toast.makeText(application, text, Toast.LENGTH_SHORT).show()
                        }
                    ).also {
                        _progressBarContainerVisibility.value = View.INVISIBLE
                    }
                }

                return false
            }

            override fun onQueryTextChange(newText: String): Boolean {
                return false
            }
        }
    }

    private val _progressBarContainerVisibility = MutableStateFlow(View.INVISIBLE)
    val progressBarContainerVisibility = _progressBarContainerVisibility.asStateFlow()

    private val _showDetail = MutableSharedFlow<DetailModel>()
    val showDetail = _showDetail.asSharedFlow()

    private val _searchViewClearFocus = MutableSharedFlow<Unit>()
    val searchViewClearFocus = _searchViewClearFocus.asSharedFlow()

    private val selectedItemListener by lazy {
        object : SearchAdapter.OnSelectedItemListener {
            override fun onSelectedItem(position: Int) {
                dataSet?.let {
                    val item = it[position]
                    val model = DetailModel(item.pageId, item.title)

                    viewModelScope.launch {
                        _showDetail.emit(model)
                    }
                }
            }
        }
    }

    companion object {
        private const val SAVED_STATE_HANDLE_KEY_SEARCH_VIEW_QUERY =
            "SAVED_STATE_HANDLE_KEY_SEARCH_VIEW_QUERY"
    }
}