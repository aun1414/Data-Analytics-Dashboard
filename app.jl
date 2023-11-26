using Clustering
import RDatasets: dataset
import DataFrames
using GenieFramework
using CategoricalArrays
@genietools
# Examples: {mlmRev,Early} {datasets,iris}
global dict = Dict(
    "iris" => "datasets",
    "Early" => "mlmRev",
    "bdf" => "mlmRev",
    "Exam" => "mlmRev",
)
global keys_array = collect(keys(dict))

global dataPackage = "datasets"
global set = "iris"
global data = dataset(dataPackage, set)

global plotTypes = ["scatter", "bar", "violin", "box"]

global changingDatasets = false;

#features = [Symbol(c) for c in names(data)[1:end-2]]

# Get column names of categorical columns
global categorical_columns = [name for name in names(data) if eltype(data[!, name]) <: CategoricalValue]

# Select all non-categorical columns as features and convert to symbols
global features = [Symbol(c) for c in setdiff(names(data), categorical_columns)]

#categorical_columns = [Symbol(element) for element in categorical_columns]
# Insert a new column with zeros
global data = DataFrames.insertcols!(data, :Cluster => zeros(Int, size(data, 1)))


function cluster(features, no_of_clusters=3, no_of_iterations=10)
    println(features)
    feats = Matrix(data[:, [c for c in features]])' |> collect
    result = kmeans(feats, no_of_clusters; maxiter=no_of_iterations)
    global data[!, :Cluster] = assignments(result)
end

function cluster2(features, no_of_clusters=3, no_of_iterations=10)
    feats = Matrix(data[:, [c for c in features]])' |> collect
    result = kmeans(feats, no_of_clusters; maxiter=no_of_iterations)
end


@handlers begin
    @out features
    @out categorical_columns
    @out keys_array
    @out plotTypes
    @in no_of_clusters = 3
    @in no_of_iterations = 10
    @in datasetName = keys_array[1]
    @in xfeature = features[1]
    @in yfeature = features[2]
    @in gfeature = categorical_columns[1]
    @in plotType = plotTypes[1]
    @out datatable = DataTable(data)
    @out datatablepagination = DataTablePagination(rows_per_page=50)
    @out irisplot = PlotData[]
    @out clusterplot = PlotData[]

    @onchange isready, datasetName begin
        global changingDatasets = true
        println(datasetName)
        global dataPackage = get(dict, datasetName, "iris")
        println(dataPackage)
        global set = datasetName
        global data = dataset(dataPackage, set)

        global categorical_columns = [name for name in names(data) if eltype(data[!, name]) <: CategoricalValue]

        # Select all non-categorical columns as features and convert to symbols
        global features = [Symbol(c) for c in setdiff(names(data), categorical_columns)]
        xfeature = features[1]
        yfeature = features[2]
        #categorical_columns = [Symbol(element) for element in categorical_columns]
        # Insert a new column with zeros
        global data = DataFrames.insertcols!(data, :Cluster => zeros(Int, size(data, 1)))
        global changingDatasets = false
        gfeature = categorical_columns[1]

    end

    @onchange isready, xfeature, yfeature, no_of_clusters, no_of_iterations, gfeature, plotType begin
        if (!changingDatasets)
            println(xfeature)
            println(yfeature)
            cluster(features, no_of_clusters, no_of_iterations)
            datatable = DataTable(data)
            grouped_df = DataFrames.combine(DataFrames.groupby(data, Symbol(gfeature)), DataFrames.nrow => :count)
            println(grouped_df)
            irisplot = plotdata(data, xfeature, yfeature; groupfeature=Symbol(gfeature), plottype=plotType)
            #irisplot = plotdata(data, xfeature, yfeature; groupfeature=Symbol(gfeature))
            clusterplot = plotdata(data, xfeature, yfeature; groupfeature=:Cluster)
        end
    end
end


meta = Dict("og:title" => "Iris Clustering", "og:description" => "Dashboard to analyze k-means clustering results for iris dataset.", "og:image" => "/preview.png")
layout = DEFAULT_LAYOUT(meta=meta)
@page("/", "app.jl.html", layout)