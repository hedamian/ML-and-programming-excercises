#Pydot package
#The pydot package is an interface to Graphviz. It is written in pure Python, and it can parse 
#and dump into the DOT language used by Graphviz. A folder tree structure in a computer 
#comprising of a directory, sub-directory, files, etc. is also an example of a directed graph.
#In the following section, I am going to explain how the pydot package can be used to get the
#folder tree structure.

#Folder tree using Pydot package
#I start with creating a directed graph object called G. The os module in Python provides a portable way 
#of using operating system-dependent functionalities. os.getcwd() returns the current working directory
#including the path, which I assign as rootDir. From the rootDir, I get the name of the directory only 
#(graph_visualisation_basics) and pass it as currentDir. I add a node for currentDir and fill it with
#green color. By using a for loop, I define the nodes for each subdirectory and file and add edges 
#between them. Next, I fill the nodes for subdirectory with yellow color and the files with orange
#color. At the same time, I ignore the hidden folders whose name starts with a ..


import pydot
import os
from IPython.display import Image, display

#Return current working directory including the path
rootDir = os.getcwd()

#Create a graph object of directed type
G = pydot.Dot(graph_type = "digraph")

#Get the name of the current directory only
currentDir = rootDir.split("/")[-1]

#Add a node named after current directory filled with green color
node = pydot.Node(currentDir, style = "filled", fillcolor = "green")
G.add_node(node)

#Loop through the directory, subdirectory and files of root directory
for root, dirs, files in os.walk(rootDir):
    
    #Ignore hidden files and folder
    if root==rootDir or (root.split("/")[6].startswith(".") == False):
       
        for subdir in dirs:
            
            #Ignore hidden folder
            if subdir.startswith(".") == False:
                
                #Add nodes with name of subdirectory and fill it with yellow color
                node = pydot.Node(subdir, style = "filled", fillcolor = "yellow")
                G.add_node(node)

                #Add the edge between root directory and sub directory
                edge = pydot.Edge(root.split("/")[-1], subdir)
                G.add_edge(edge)
        
        for file in files:
            
            #Add node for each file and fill it with orange color
            node = pydot.Node(file, style = "filled", fillcolor = "orange")
            G.add_node(node)

            #Add edge between directory/subdirectory and file 
            edge = pydot.Edge(root.split("/")[-1], file)
            G.add_edge(edge)

#Create the image of folder tree
im = Image(G.create_jpeg())

#Display the image
display(im)

#Save the image in jpeg format
G.write_jpeg("output/folder_tree.jpeg")


#Pydot package
#The pydot package is an interface to Graphviz. It is written in pure Python,
#and it can parse and dump into the DOT language used by Graphviz. A folder tree structure in a computer comprising
#of a directory, sub-directory, files, etc. is also an example of a directed graph. In the following section, 
#I am going to explain how the pydot package can be used to get the folder tree structure.

#Folder tree using Pydot package
#I start with creating a directed graph object called G. The os module in Python provides a portable way of 
#using operating system-dependent functionalities. os.getcwd() returns the current working directory including 
#the path, which I assign as rootDir. From the rootDir, I get the name of the directory only (graph_visualisation_basics)
#and pass it as currentDir. I add a node for currentDir and fill it with green color. By using a for loop,
#I define the nodes for each subdirectory and file and add edges between them. Next, 
#I fill the nodes for subdirectory with yellow color and the files with orange color.
#At the same time, I ignore the hidden folders whose name starts with a