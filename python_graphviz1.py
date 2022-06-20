 #import graphviz
# f = graphviz.Digraph(filename = “output/plain organogram 1.gv”)
# names = ['A','B','C','D','E','F','G','H']
# positions = ['CEO','Team A Lead','Team B Lead', 'Staff A','Staff B', 'Staff C', 'Staff D', 'Staff E']
# for name, position in zip(names, positions):
##  f.node(name, position)
# #Specify edges
# f.edge('A','B'); f.edge('A','C') #CEO to Team Leads
# f.edge('B','D'); f.edge('B','E') #Team A relationship
# f.edge('C','F'); f.edge('C','G'); f.edge('C','H') #Team B relationship
# 
# f

# print(f)

import graphviz
f = graphviz.Digraph(filename = 'output/plain_organogram_2.png')
names = ["A","B","C","D","E","F","G","H"]
positions = ["CEO","Team A Lead","Team B Lead", "Staff A","Staff B", "Staff C", "Staff D", "Staff E"]
for name, position in zip(names, positions):
    if name == "A":
        f.node(name, position, shape = "oval")

    elif name in ["B","C"]:
        f.node(name, position, shape = "box")
    else:
        f.node(name, position, shape = "plaintext")
#Specify edges
f.edge("A","B"); f.edge("A","C")   #CEO to Team Leads
f.edge("B","D"); f.edge("B","E")   #Team A relationship
f.edge("C","F"); f.edge("C","G"); f.edge("C","H")   #Team B relationship
    
f

print(f)