import graphviz
f=graphviz.Digraph(filename='filled_colorful_organogram1.gv')
names = ["A","B","C","D","E","F","G","H"]
positions = ["CEO","Team A Lead","Team B Lead", "Staff A","Staff B", "Staff C", "Staff D", "Staff E"]
colors = ["black", "skyblue", "mistyrose", "skyblue", "skyblue", "mistyrose", "mistyrose", "mistyrose"]
for name, position, color in zip(names, positions, colors):
    if name== "A":
        f.node(name, position, color = color)
    else:
        f.node(name, position, style = "filled", color = color)
    
#Specify edges
f.edge("A","B"); f.edge("A","C")   #CEO to Team Leads
f.edge("B","D"); f.edge("B","E")   #Team A relationship
f.edge("C","F"); f.edge("C","G"); f.edge("C","H")   #Team B relationship
    
f.view()



