import graphviz
f = graphviz.Digraph(filename = 'output/colorful organogram 1.gv')
names = ["A","B","C","D","E","F","G","H"]
positions = ["CEO","Team A Lead","Team B Lead", "Staff A","Staff B", "Staff C", "Staff D", "Staff E"]
colors = ["black", "blue", "red", "blue", "blue", "red", "red", "red"]
for name, position, color in zip(names, positions, colors):
    f.node(name, position, color = color)
    
#Specify edges
#CEO to Team Leads
f.edge("A","B", color = "blue", label = "A"); f.edge("A","C", color = "red", label = "B")   
#Team A
f.edge("B","D", color = "blue"); f.edge("B","E", color = "blue")   
#Team B 
f.edge("C","F", color = "red"); f.edge("C","G", color = "red"); f.edge("C","H", color = "red")   
    
f