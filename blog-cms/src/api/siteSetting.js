import axios from '@/util/request'

export function getSiteSettingData() {
	return axios({
		url: 'siteSettings',
		method: 'GET'
	})
}

export function update(settings, deleteIds) {
	return axios({
		url: 'siteSettings',
		method: 'POST',
		data: {
			settings,
			deleteIds
		}
	})
}

export function getWebTitleSuffix() {
	return axios({
		url: 'webTitleSuffix',
		method: 'GET'
	})
}

export function getSettingByName(name){
    return axios({
		url: 'site-setting/get-by-name',
		method: 'GET',
		params: {
			...name
		}
	})
}