package work.d128.aacsample.fragment

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.Menu
import android.view.MenuInflater
import android.view.View
import android.view.ViewGroup
import android.widget.SearchView
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.fragment.app.commit
import androidx.fragment.app.replace
import androidx.lifecycle.SavedStateViewModelFactory
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.coroutines.flow.collect
import work.d128.aacsample.R
import work.d128.aacsample.databinding.FragmentSearchBinding
import work.d128.aacsample.view_model.SearchViewModel

class SearchFragment : Fragment() {
    private var binding: FragmentSearchBinding? = null
    private val viewModel by lazy {
        SavedStateViewModelFactory(
            requireActivity().application,
            this
        ).create(SearchViewModel::class.java).also { viewModel ->
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

        setHasOptionsMenu(true)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentSearchBinding.inflate(inflater, container, false)
        binding?.lifecycleOwner = this
        binding?.viewModel = viewModel
        return binding?.root
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding?.recyclerView?.layoutManager = LinearLayoutManager(view.context)
        binding?.recyclerView?.adapter = viewModel.adapter

        binding?.progressContainerView?.setOnTouchListener { _, _ -> true }

    }

    override fun onDestroyView() {
        super.onDestroyView()

        // https://developer.android.com/topic/libraries/view-binding#fragments
        binding = null
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)

        inflater.inflate(R.menu.options_menu, menu)

        searchView = (menu.findItem(R.id.search).actionView as SearchView).apply {
            isIconifiedByDefault = false
            setOnQueryTextListener(viewModel.searchViewQueryTextListener)
            setQuery(viewModel.searchViewQuery, true)
        }
    }

    override fun onDestroyOptionsMenu() {
        super.onDestroyOptionsMenu()

        searchView = null
    }

    override fun onResume() {
        super.onResume()

        (requireActivity() as AppCompatActivity).supportActionBar?.setDisplayHomeAsUpEnabled(
            false
        )
    }
}
