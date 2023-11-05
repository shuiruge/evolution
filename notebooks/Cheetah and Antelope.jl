### A Pluto.jl notebook ###
# v0.19.31

using Markdown
using InteractiveUtils

# ╔═╡ 5c66ed00-a1d9-4d44-bfaa-029ef4cebb36
include("utils.jl")

# ╔═╡ 49442662-796f-11ee-09c9-273d52f72046
md"""
## Abstract

This notebook extends the "Animal on Prairie.jl" to multiple animals.
"""

# ╔═╡ f930f34c-dba3-42a0-a2e2-ed6b08d11fc1
md"""
## Setup

We set up the instance as follow:
- configuration space:
  - is vegetarian
  - is sarcophagous
  - has long legs
- field:
  - cheetah
  - antelope
- field values:
  - true: １
  - false: -1

For giving the "interaction", we have assumptions:
- either vegetarian or sarcophagous
- length of legs of cheetah and that of antelope are proportional, so that their speeds are comparable.
"""

# ╔═╡ 8ba45433-2cfe-4c3a-8399-d4e10036b50c
const configspace = [
    "cheetah (or antelop) is sarcophagous",
    "cheetah (or antelop) is vegetarian",
    "cheetah (or antelop) has long legs",
    "antelop (or cheetah) is sarcophagous",
    "antelop (or cheetah) is vegetarian",
    "antelop (or cheetah) has long legs",
]

# ╔═╡ 3d95b07a-a88f-44e3-94ee-934f0ef0b2f4
const correlation = [
	 1  -1   0  -1   1   0;
	-1   1   0   1  -1   0;
	 0   0   1   0   0   1;
	-1   1   0   1  -1   0;
	 1  -1   0  -1   1   0;
	 0   0   1   0   0   1;
]

# ╔═╡ d3b57122-c5c3-4ab9-803c-d32f3a194ca2
function energy(x)
	- transpose(x) * correlation * x
end

# ╔═╡ 314f734c-f700-431f-be7a-b91a0391400c
fixed_points = find_fixed_points(
	energy,
	size(correlation, 1),
	100,
	500)

# ╔═╡ 79f96592-bb13-41c5-92f9-e29fdb6bb844
for x in fixed_points
	println("configuration:")
	for i = 1:size(x, 1)
		println("  - $(configspace[i]): $(x[i] > 0)")
	end
	println("energy: $(energy(x))")
	println()
end

# ╔═╡ d880e0f4-3630-4a2a-8993-7d12e2669bf8
md"""
## Conclusion

TODO
"""

# ╔═╡ Cell order:
# ╟─49442662-796f-11ee-09c9-273d52f72046
# ╟─f930f34c-dba3-42a0-a2e2-ed6b08d11fc1
# ╠═8ba45433-2cfe-4c3a-8399-d4e10036b50c
# ╠═3d95b07a-a88f-44e3-94ee-934f0ef0b2f4
# ╠═d3b57122-c5c3-4ab9-803c-d32f3a194ca2
# ╠═5c66ed00-a1d9-4d44-bfaa-029ef4cebb36
# ╠═314f734c-f700-431f-be7a-b91a0391400c
# ╠═79f96592-bb13-41c5-92f9-e29fdb6bb844
# ╠═d880e0f4-3630-4a2a-8993-7d12e2669bf8
