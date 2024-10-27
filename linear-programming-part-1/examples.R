# Load libraries
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)


# Define the problem data
values <- c(10, 20, 30, 40) # values of the items
weights <- c(1, 3, 4, 5) # weights of the items
capacity <- 7 # weight capacity of the knapsack
n <- length(values) # number of items

# Build the model
model <- MIPModel() |>
    add_variable(x[i], i = 1:n, type = "binary") |>
    set_objective(sum_over(values[i] * x[i], i = 1:n), "max") |>
    add_constraint(sum_over(weights[i] * x[i], i = 1:n) <= capacity)

# Solve the model
result <- solve_model(model, with_ROI(solver = "glpk"))

# Extract the solution
solution <- get_solution(result, x[i])

# Display the results
print(solution)

# Load libraries
library(ompr)
library(ompr.roi)
library(ROI.plugin.glpk)

# Define the problem data
values <- c(10, 20, 30, 40) # values of the items
weights <- c(1, 3, 4, 5) # weights of the items
capacity <- 7 # weight capacity of the knapsack
numberOfItems <- length(values) # number of items

# Build the model
model <- MIPModel() |>
    add_variable(
        itemsInSack[item],
        item = 1:numberOfItems,
        type = "binary"
    ) |>
    set_objective(sum_over(values[item] * itemsInSack[item], item = 1:numberOfItems), "max") |>
    add_constraint(sum_over(weights[item] * itemsInSack[item], item = 1:numberOfItems) <= capacity)


# Solve the model
result <- solve_model(model, with_ROI(solver = "glpk"))


# Extract the solution
solution |>
    dplyr::filter(value > 0) |>
    dplyr::select(-value) |>
    dplyr::mutate(
        value = values[item]
    )

# Display the results
print(solution)
