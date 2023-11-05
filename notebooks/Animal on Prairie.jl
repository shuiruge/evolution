### A Pluto.jl notebook ###
# v0.19.31

using Markdown
using InteractiveUtils

# ╔═╡ bd5f7c1c-af3c-46cc-8f44-0e7675f1c2a2
include("utils.jl")

# ╔═╡ 49442662-796f-11ee-09c9-273d52f72046
md"""
## Abstract

This notebook gives an instance of biology indicating that "interaction" of genotypes can be described by correlations which in turn furnishes a plausible distribution of genotypes by maximazing the information (the MaxEnt principle by Jaynes).
"""

# ╔═╡ 0e56d348-6502-4c9c-9bd4-b3e0819cbda5
md"""
## Setup

We set up the instance as follow:
- configuration space:
  - is vegetarian
  - is sarcophagous
  - has long legs
  - has high fertility rate
- field: animal of prairie
- field values:
  - true: １
  - false: -1

For giving the "interaction", we have assumptions:
- either vegetarian or sarcophagous
- sarcophagous animal has long legs
- vegetarian animal has high fertility rate
"""

# ╔═╡ bc10f42b-8080-42ba-b02c-ad3cc3e54b42
const configspace = [
    "is sarcophagous",
    "is vegetarian",
    "has long legs",
    "has high fertility rate",
]

# ╔═╡ 90a60a1c-7d57-4d94-9aea-93318f57f167
md"""
Based on the assumptions, two-point correlation can be given as follow:
"""

# ╔═╡ 3d95b07a-a88f-44e3-94ee-934f0ef0b2f4
const correlation = [
	 1  -1   1   0;
	-1   1   0   1;
	 1   0   1   0;
	 0   1   0   1;
]

# ╔═╡ a30d7869-643b-4670-b922-83b5737ab129
md"""
Now, we come to the energy function of the Boltzmann distribution induced
from the MaxEnt principle. We should fit the Lagrangian multiplier of the
two-point interaction in the energy function by MCMC simulation. But, as
suggested by MacKay in dicussing Hopfield network, in the case where only
two-point interactions exist, simply using the two-point correlation as the
Lagrangian multiplier provides a good approximation.
"""

# ╔═╡ d3b57122-c5c3-4ab9-803c-d32f3a194ca2
function energy(x)
	- transpose(x) * correlation * x
end

# ╔═╡ 879c2956-8799-4385-9175-d9522a461250
fixed_points = find_fixed_points(
	energy,
	size(correlation, 1),
	100,
	500)

# ╔═╡ c60dc4a3-da99-455f-9dbb-df12a251d7cb
for x in fixed_points
	println("configuration:")
	for i = 1:size(x, 1)
		println("  - $(configspace[i]): $(x[i] > 0)")
	end
	println("energy: $(energy(x))")
	println()
end

# ╔═╡ d1c3809c-a560-4f4a-8241-a18f6ef79a21
md"""
## Conclusion

This result indicates that sarcophagous animal shall have long legs, so as to run faster, and that vegetarian animal shall have high fertility rate. To gain a balance, this result is plausible.
"""

# ╔═╡ 37ca2d6e-472b-48b1-a4f9-de04a2647f93
md"""
## Extension

We can extend this to involve "interactions" between multiple animals, like cheetah and antelope. This will extend the configuration space by concatenating the configuration of cheetah and that of antelope together as one. Following the same computation, we will surely arrive its result too. For details, see "Cheetah and Antelope.jl".
"""

# ╔═╡ Cell order:
# ╟─49442662-796f-11ee-09c9-273d52f72046
# ╟─0e56d348-6502-4c9c-9bd4-b3e0819cbda5
# ╠═bc10f42b-8080-42ba-b02c-ad3cc3e54b42
# ╟─90a60a1c-7d57-4d94-9aea-93318f57f167
# ╠═3d95b07a-a88f-44e3-94ee-934f0ef0b2f4
# ╟─a30d7869-643b-4670-b922-83b5737ab129
# ╠═d3b57122-c5c3-4ab9-803c-d32f3a194ca2
# ╠═bd5f7c1c-af3c-46cc-8f44-0e7675f1c2a2
# ╠═879c2956-8799-4385-9175-d9522a461250
# ╟─c60dc4a3-da99-455f-9dbb-df12a251d7cb
# ╟─d1c3809c-a560-4f4a-8241-a18f6ef79a21
# ╟─37ca2d6e-472b-48b1-a4f9-de04a2647f93
