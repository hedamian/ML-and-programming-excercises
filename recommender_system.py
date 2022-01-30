#Implementing a Recommender System
#Let’s see how we can make use of the result from SVD to build a recommender system.
#Firstly, let’s download the dataset from this link (caution: it is 600MB big)
#http://deepyeti.ucsd.edu/jmcauley/datasets/librarything/lthing_data.tar.gz
#This dataset is the “Social Recommendation Data” from “Recommender Systems and Personalization Datasets“.
#It contains the reviews given by users on books on Librarything.
#What we are interested are the number of “stars” a user given to a book.


import tarfile

# Read downloaded file from:
# http://deepyeti.ucsd.edu/jmcauley/datasets/librarything/lthing_data.tar.gz
with tarfile.open("lthing_data.tar.gz") as tar:
    print("Files in tar archive:")
    tar.list()

    with tar.extractfile("lthing_data/reviews.json") as file:
        count = 0
        for line in file:
            print(line)
            count += 1
            if count > 3:
                break


#Each line in reviews.json is a record. We are going to extract the “user”, “work”, and “stars” field of each record
# as long as there are no missing data among these three. Despite the name, the records are not well-formed JSON strings
#(most notably it uses single quote rather than double quote).
#Therefore, we cannot use json package from Python but to use ast to decode such string:

import ast

reviews = []
with tarfile.open("lthing_data.tar.gz") as tar:
    with tar.extractfile("lthing_data/reviews.json") as file:
        for line in file:
            record = ast.literal_eval(line.decode("utf8"))
            if any(x not in record for x in ['user', 'work', 'stars']):
                continue
            reviews.append([record['user'], record['work'], record['stars']])
print(len(reviews), "records retrieved")


#Now we should make a matrix of how different users rate each book.
#We make use of the pandas library to help convert the data we collected into a table:

# Print a few sample of what we collected

import pandas as pd
reviews = pd.DataFrame(reviews, columns=["user", "work", "stars"])
print(reviews.head())


# Look for the users who reviewed more than 50 books
usercount = reviews[["work","user"]].groupby("user").count()
usercount = usercount[usercount["work"] >= 50]
print(usercount.head())


# Look for the books who reviewed by more than 50 users
workcount = reviews[["work","user"]].groupby("work").count()
workcount = workcount[workcount["user"] >= 50]
print(workcount.head())

# Keep only the popular books and active users
reviews = reviews[reviews["user"].isin(usercount.index) & reviews["work"].isin(workcount.index)]
print(reviews)

reviewmatrix = reviews.pivot(index="user", columns="work", values="stars").fillna(0)

#Then we apply the SVD (this will take a while):

from numpy.linalg import svd
matrix = reviewmatrix.values
u, s, vh = svd(matrix, full_matrices=False)


#By default, the svd() returns a full singular value decomposition.
#We choose a reduced version so we can use smaller matrices to save memory. The columns of vh correspond to the books.
#We can based on vector space model to find which book are most similar to the one we are looking at:

import numpy as np
def cosine_similarity(v,u):
    return (v @ u)/ (np.linalg.norm(v) * np.linalg.norm(u))

highest_similarity = -np.inf
highest_sim_col = -1
for col in range(1,vh.shape[1]):
    similarity = cosine_similarity(vh[:,0], vh[:,col])
    if similarity > highest_similarity:
        highest_similarity = similarity
        highest_sim_col = col

print("Column %d (book id %s) is most similar to column 0 (book id %s)" %
        (highest_sim_col, reviewmatrix.columns[col], reviewmatrix.columns[0])
)
