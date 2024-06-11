plot_hook <- knitr::knit_hooks$get("plot")

knitr::knit_hooks$set(
    source = function(x, options) {
        paste0(
            "\\begin{listing}\n",
            "\\begin{minted}", "{", options$engine, "}", "\n",
            x,
            "\n\\end{minted}\n"
        )
    },
    output = function(x, options) {
        paste0(x, "\\end{listing}\n")
    },
    plot = function(x, options) {
        paste0("\\end{listing}\n", plot_hook(x, options))
    }
    # inlines are handed by panoc lua filter
)
