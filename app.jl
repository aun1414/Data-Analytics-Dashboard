using Clustering
import RDatasets: dataset
import DataFrames
using GenieFramework
using CategoricalArrays
@genietools
# Examples: {mlmRev,Early} {datasets,iris}
const dataPackage = "mlmRev"
const set = "bdf"
data = dataset(dataPackage, set)

#features = [Symbol(c) for c in names(data)[1:end-2]]

# Get column names of categorical columns
categorical_columns = [name for name in names(data) if eltype(data[!, name]) <: CategoricalValue]

# Select all non-categorical columns as features and convert to symbols
features = [Symbol(c) for c in setdiff(names(data), categorical_columns)]

#categorical_columns = [Symbol(element) for element in categorical_columns]
# Insert a new column with zeros
data = DataFrames.insertcols!(data, :Cluster => zeros(Int, size(data, 1)))

function cluster(no_of_clusters=3, no_of_iterations=10)
    feats = Matrix(data[:, [c for c in features]])' |> collect
    result = kmeans(feats, no_of_clusters; maxiter=no_of_iterations)
    data[!, :Cluster] = assignments(result)
end

@handlers begin
    @out features
    @out categorical_columns
    @in no_of_clusters = 2
    @in no_of_iterations = 10
    @in xfeature = features[1]
    @in yfeature = features[2]
    @in gfeature = categorical_columns[1]
    @out datatable = DataTable(data)
    @out datatablepagination = DataTablePagination(rows_per_page=50)
    @out irisplot = PlotData[]
    @out clusterplot = PlotData[]

    @onchange isready, xfeature, yfeature, no_of_clusters, no_of_iterations, gfeature begin
        cluster(no_of_clusters, no_of_iterations)
        datatable = DataTable(data)
        irisplot = plotdata(data, xfeature, yfeature; groupfeature=Symbol(gfeature))
        clusterplot = plotdata(data, xfeature, yfeature; groupfeature=:Cluster)
    end
end


meta = Dict("og:title" => "Iris Clustering", "og:description" => "Dashboard to analyze k-means clustering results for iris dataset.", "og:image" => "/preview.png")
layout = DEFAULT_LAYOUT(meta=meta)
@page("/", "app.jl.html", layout)