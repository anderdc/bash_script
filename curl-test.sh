#Ander
#for this script to run, must ensure site is up and running LOCALLY
#first get total number of posts
NUM=$(curl -s http://127.0.0.1:5000/api/timeline_post | jq '.[] | length')
#make a curl post
NAME=$(date)        #make a unique name for this test using curr time
curl --request POST http://127.0.0.1:5000/api/timeline_post -d "name=$NAME&email=curl_test@mlh.com&content=This was posted by a script."
ERROR=$? #if last command had an error, ERROR will be 1 
if [[ $ERROR -eq 1 ]]
then
echo "Something went wrong with api POST"
exit 1
fi
#make a GET request
NEWNUM=$(curl -s --request GET http://127.0.0.1:5000/api/timeline_post | jq '.[] | length')
#compare and check if the post actually went through
if [[ $NEWNUM -eq $NUM ]]
then
echo "something went wrong after POST attempt during GET"
exit 1
fi

#if all went well
echo "test was successful"
echo "previous number of posts: $NUM"
echo "new number of posts: $NEWNUM"

