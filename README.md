## Introduction:
-To provide a powerful and easy to use dashboard for in-depth analysis of large sets of data. <br/>
-Allows the user to easily visualize data, define parameters and view results. <br/>
-Intelligently reads the dataset, identifying various properties of the fields and sets up the UI accordingly. <br/>
-Generic and scalable solution, allowing the user to throw in any dataset and expect it to perform accordingly. <br/>
-Can update dataset and adapt interface in real-time. <br/>
-Employes K-means algorithm for generic classification along with data grouping using a specified group feature. <br/>
-Dataset table for data exploration. <br/>
-Interactive data plots with zoom and hover features. <br/>
-Customizable data plots, allowing the user to select a different type of plot to view data from different perspectives.<br/>
-Helps in creating inferences and relations. <br/>

## App Implementation:
-Used the Genie Framework along with HTML/CSS for the UI development. <br/>
-Used the RDatasets library to import various datasets the user can explore. <br/>
-Parsed the data to create a dataset. <br/>
-Applied various filtering techniques that involved reading the dataset and intelligently detecting the properties of each feature, identifying numerical and categorical data etc. <br/>
-Added a data table to view tabular data.<br/>
-Implemented a generalized K-means algorithm. <br/>
-Implemented a generalized grouping. <br/>
-Implemented various different dynamic data plots, allowing interactivity such as zoom and hover states to show different insights based on the plot type. <br/>

## UI Implementation:
The Geniebuilder provides highly effective tools for UI development. <br/>
Allows the user to use a GUI to create and customize UI and auto-generate the HTML and CSS. <br/>
User has HTML/CSS tools at their disposal to customize the UI as they would expect. <br/>
Has seamless support for working via HTML/CSS files for specific cases or if the user desires to use the conventional methods. <br/>
Very useful for creating UI for a genie application, but can also be used for rapid prototyping of UI for any website. <br/>

## Data Processing and UI:
-We first created the UI components and used placeholder values. </br>
-We then created a model that intelligently reads CSV based data and is able to distinguish features and categories and extract other useful inferences. </br>
-Using macros such as @in, @out, @handlers, @onchange, @page and more, we created routing and bridges between the UI and scripting logic. </br>
-Connected UI flow to data. </br>
-Populated each UI component (Dropdown, sliders) based on the current dataset. </br>
-Generated each graph and plot based on the dataset. </br>
-Added graph interactivity features such as zooming in the data and hover states to study a data point. </br>
-Adapted interactivity for each type of data plot (IQ, Medians for distribution plots). </br>
-Generated a datatable with pagination to allow the user to look through the entire dataset. </br>
-Scaled our system to adapt to any dataset, even very large ones with dozens of diverse features. </br>

## Screenshots:
![s7](https://github.com/aun1414/Data-Analytics-Dashboard/assets/106032365/612c97d4-8805-42fd-a8c5-d519f22e69d4)
![s8](https://github.com/aun1414/Data-Analytics-Dashboard/assets/106032365/4b12d9fb-fa2b-4d12-a066-d3d6661e8e3f)





