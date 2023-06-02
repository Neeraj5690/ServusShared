function fn(){
	var env = karate.env
	if(!env){
		env='dev';
			}
	var config = {
		env:env,
		myframeowrk:'Karate Famework',
		baseurl: 'http://universities.hipolabs.com/search',
		tokenID: 'e404c1112a7ecca0c2ce3db541472927531477414ad6ea11331f9e691430e732',
		baseurl1: 'https://gorest.co.in/public/v2/users'
		}
return config
	}
