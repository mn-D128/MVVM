package work.d128.aacsample.fragment

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.ActionBar
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import work.d128.aacsample.databinding.FragmentDetailBinding
import work.d128.aacsample.model.DetailModel

class DetailFragment : Fragment() {
    private var model: DetailModel? = null
    private var binding: FragmentDetailBinding? = null
    private val actionBar: ActionBar?
        get() = (requireActivity() as AppCompatActivity).supportActionBar


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        model = arguments?.getParcelable(BUNDLE_KEY_MODEL)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentDetailBinding.inflate(inflater, container, false)
        binding?.lifecycleOwner = this
        return binding?.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        model?.url?.let {
            binding?.webView?.loadUrl(it)
        }

        actionBar?.title = model?.title
    }

    override fun onDestroyView() {
        super.onDestroyView()

        // https://developer.android.com/topic/libraries/view-binding#fragments
        binding = null
    }

    override fun onResume() {
        super.onResume()

        actionBar?.setDisplayHomeAsUpEnabled(true)
    }

    companion object {
        private const val BUNDLE_KEY_MODEL = "BUNDLE_KEY_MODEL"

        fun createArguments(model: DetailModel): Bundle {
            return Bundle().apply {
                putParcelable(BUNDLE_KEY_MODEL, model)
            }
        }
    }
}