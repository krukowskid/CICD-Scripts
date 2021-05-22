import json 
import base64
import requests
import datetime


def getAnonUsers():
    response = requests.get("https://randomuser.me/api/?results=5000")
    results = (response.json()['results'])
    return(results) 

def getBase64(url):
    return base64.b64encode(requests.get(url).content)

with open('originalFile.json', 'r', encoding="utf8") as file:
    jsonData = json.load(file)
    anon = getAnonUsers()   
    i = 0
    for item in jsonData:     
        if ('profilesCollection' in item):
            for profilesCollectionObjects in item['profilesCollection']: 
                if ('firstName' in profilesCollectionObjects):
                    profilesCollectionObjects['firstName'] = anon[i]['name']['first']
                if ('lastName' in profilesCollectionObjects):
                    profilesCollectionObjects['lastName'] = anon[i]['name']['last']
                if ('email' in profilesCollectionObjects):
                    profilesCollectionObjects['email'] = (anon[i]['email']).replace('@example.com','@yourdomain.pl')
                if ('dateOfBirth' in profilesCollectionObjects):
                    profilesCollectionObjects['dateOfBirth'] = (anon[i]['dob']['date']).split('T')[0]+'T00:00:00Z'
                if ('gender' in profilesCollectionObjects):
                    if (anon[i]['gender'] == "female"): 
                        profilesCollectionObjects['gender'] = 1
                    elif (anon[i]['gender'] == "male"):
                        profilesCollectionObjects['gender'] = 2
                if ('avatar' in profilesCollectionObjects):
                    profilesCollectionObjects['avatar'] = "data:image/jpeg;base64," + getBase64(anon[i]['picture']['large']).decode('utf-8')

                if ('syncSnapshot' in profilesCollectionObjects):
                    for syncSnapshotObjects in profilesCollectionObjects['syncSnapshot']:
                        if ('firstName' in syncSnapshotObjects):
                            profilesCollectionObjects['syncSnapshot']['firstName'] = anon[i]['name']['first']
                        if ('lastName' in syncSnapshotObjects):
                            profilesCollectionObjects['syncSnapshot']['lastName'] = anon[i]['name']['last']
                        if ('email' in syncSnapshotObjects):
                            profilesCollectionObjects['syncSnapshot']['email'] = (anon[i]['email']).replace('@example.com','@yourdomain.pl')
                        if ('dateOfBirth' in syncSnapshotObjects):
                            profilesCollectionObjects['syncSnapshot']['dateOfBirth'] = datetime.datetime.strptime(anon[i]['dob']['date'], "%Y-%m-%dT%H:%M:%S.%fZ").strftime('%Y/%m/%d 00:00:00')
                        if ('gender' in syncSnapshotObjects):
                            if (anon[i]['gender'] == "female"): 
                                profilesCollectionObjects['syncSnapshot']['gender'] = 1
                            elif (anon[i]['gender'] == "male"):
                                profilesCollectionObjects['syncSnapshot']['gender'] = 2
                i=i+1

with open('outile.json', 'w', encoding="utf8") as file:
    json.dump(jsonData, file, indent=2, ensure_ascii=False)
