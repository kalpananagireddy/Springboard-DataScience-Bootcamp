# Proposal for 1st Capstone Project

**Title:** Spam filter for Youtube comments

**Problem:** Youtube is one of the most popular video sharing platform with more than 1 billion users. Users have long been outraged by the overwhelming number of spam messages in the comment section. In 2012 users created a petition asking Youtube to provide tools to deal with undesired content. In 2013, spam problem gets worse as Google overhauled the YouTube comment system to connect it to Google+, which allows users to post links. This attracts more malicious users to self-promote their videos using the platform. This project will build a spam filter to automatically filter spam comments.

**Who might care?** Spam comments are annoying for content creators, for the users as well as platform owner. Content creators want to read about how their fans reacts to the video they created. Users want to glance through the comments to connect with other fans as well as with their favorites content creators. Platform owner want to get rid of malacious spam to make sure their platform is safe to use and provides an enjoyable experience to all end uers.

**Data:** The data is aquired from [UCI machine learning repository](https://archive.ics.uci.edu/ml/datasets/YouTube+Spam+Collection). The data is collected through YouTube API and contains ~2000 comments extracted from 5 most popular videos on Youtube during the first half of 2015.

**Modeling approach:** Since we are dealing with a classification problem (two classes: spam and ham), we are going to extract some freatures from the analysis of spam vs ham messages, some examples of features we are explorating are: 
	*average length of the message
	*whether it contains a URL link
	*words freq
	*number of capitals
	*use of puntuation or special character
	*comment time 
We will build machine learning models around candidate features that differentiate spam vs ham comments. Some machines learning models that we might be exploring are:
*Logistic regression
*K-nearest neighbors
*Naive Bayes

**Possible limitations:** The accuracy of the model might improve by incorporating users information (such as the domain address of the malacious users, when did they sign up, how many comments they post etc)which we don't have in our dataset. The effectiveness of the model will be compromised as malacious users are adapting their stragegy to escape the spam filter 
.For example when they are aware of the algorithm behind the model they can counter engineering the strucuture of the spam comments.

**Deliverables:**
1. Notebooks for:
	a. data cleaning
	b. data exploration analysis
	c. machine learning model 

2. Imtermediate reports and final reports


    
