package work.d128.aacsample.fragment

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.Menu
import android.view.MenuInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SearchView
import androidx.fragment.app.Fragment
import androidx.fragment.app.commit
import androidx.fragment.app.replace
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.coroutines.flow.collect
import work.d128.aacsample.R
import work.d128.aacsample.databinding.FragmentSearchBinding
import work.d128.aacsample.view_model.SearchViewModel

class SearchFragment: Fragment() {
    private var binding: FragmentSearchBinding? = null
    private val viewModel :SearchViewModel by lazy {
       ViewModelProvider.AndroidViewModelFactory.getInstance(this.requireActivity().application).create(SearchViewModel::class.java).also { viewModel ->
           lifecycleScope.launchWhenResumed {
               viewModel.searchViewClearFocus.collect {
                   searchView?.clearFocus()
               }
           }

           lifecycleScope.launchWhenResumed {
               viewModel.showDetail.collect {
                   val bundle = DetailFragment.createArguments(it)
                   parentFragmentManager.commit {
                       addToBackStack(null)
                       replace<DetailFragment>(R.id.fragment_container_view, args = bundle)
                   }
               }
           }
       }
    }
    private var searchView: SearchView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        this.setHasOptionsMenu(true)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        this.binding = FragmentSearchBinding.inflate(inflater, container, false)
        this.binding?.lifecycleOwner = this
        this.binding?.viewModel = this.viewModel
        return this.binding?.root
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        this.binding?.recyclerView?.layoutManager = LinearLayoutManager(view.context)
        this.binding?.recyclerView?.adapter = this.viewModel.adapter

        this.binding?.progressContainerView?.setOnTouchListener { _, _ -> true }

    }

    override fun onDestroyView() {
        super.onDestroyView()

        // https://developer.android.com/topic/libraries/view-binding#fragments
        this.binding = null
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)

        inflater.inflate(R.menu.options_menu, menu)

        this.searchView = (menu.findItem(R.id.search).actionView as SearchView).apply {
            this.isIconifiedByDefault = false
            this.setOnQueryTextListener(viewModel.searchViewQueryTextListener)
            this.setQuery(viewModel.searchViewQuery, false)
        }
    }

    override fun onDestroyOptionsMenu() {
        super.onDestroyOptionsMenu()

        this.searchView = null
    }
}
