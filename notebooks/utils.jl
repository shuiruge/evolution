using Random: shuffle


"""
MCMC simulation (Metropolis algorithm) for gaining the Boltzmann distribution
p(x) ∝ exp(-E(x)/T), where E is the energy function.
"""
function metropolis_update!(energy, T, x)
	@assert T >= 0

	# Initialize
	is_updated = false
	next_x = copy(x)
	current_energy = energy(x)

	# Metropolis process
	for i in shuffle(1:size(x, 1))
		# Flip one dimension
		if x[i] > 0
			next_x[i] = -1
		else
			next_x[i] = 1
		end
		next_energy = energy(next_x)
		# Accept if -exp(ΔE/T) > r, where r is random in (0, 1).
		# Since T can be zero, we shall use -ΔE > T ln(r) instead.
		if current_energy - next_energy > log(rand(Float64)) * T
			x[i] = next_x[i]
			current_energy = next_energy
			is_updated = true
		else
			# Restore next_x to x
			next_x[i] = x[i]
		end
	end

	is_updated
end


"""
Search for distinct peaks (fixed points) for the Boltzmann distribution.
"""
function find_fixed_points(energy, dim, max_iter, samples)

    # Find a peak (or fixed points) of the Boltzmann distribution.
    function find_a_fixed_point(x₀)
        x = copy(x₀)
        for step = 1:max_iter
            # To find peaks instead of sampling the whole distribution,
            # we use zero temperature limit.
            is_updated = metropolis_update!(energy, 0, x)
            if is_updated == false
                return x
            end
        end
        throw(ErrorException("Maximal iteration is reached."))
    end

	fixed_point_set = Set([])
	for _ = 1:samples
		random_x = [rand([-1, 1]) for _ = 1:dim]
		fixed_point = find_a_fixed_point(random_x)
		push!(fixed_point_set, fixed_point)
	end
	fixed_point_set
end
