register $udf_jar;

define recommendation com.hortonworks.pig.mahout.recommend.Recommendation();

users = load '$users_file' using com.hortonworks.pig.MultiDelimiterStorage('::') as (user_id:long);
user = filter users by user_id == $user_id;

ratings = load '$ratings_file' using com.hortonworks.pig.MultiDelimiterStorage('::') as (user_id:long, movie_id:long, rating:float, timestamp:long);
users_ratings = group ratings all;

recommendations = foreach users_ratings generate recommendation(ratings);

store recommendations into 'recommendations';