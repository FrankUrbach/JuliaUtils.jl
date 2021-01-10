using JuliaUtils
using Documenter

makedocs(;
    modules=[JuliaUtils],
    authors="Frank Urbach",
    repo="https://GitHub.com/FrankUrbach/JuliaUtils.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaUtils.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://FrankUrbach.github.io/JuliaUtils.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="GitHub.com/FrankUrbach/JuliaUtils.jl",
)
