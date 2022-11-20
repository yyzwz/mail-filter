import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getWhitelistOne = (params) => {
    return getRequest('/whitelist/getOne', params)
}
export const getWhitelistList = (params) => {
    return getRequest('/whitelist/getByPage', params)
}
export const getWhitelistCount = (params) => {
    return getRequest('/whitelist/count', params)
}
export const addWhitelist = (params) => {
    return postRequest('/whitelist/insert', params)
}
export const editWhitelist = (params) => {
    return postRequest('/whitelist/update', params)
}
export const addOrEditWhitelist = (params) => {
    return postRequest('/whitelist/insertOrUpdate', params)
}
export const deleteWhitelist = (params) => {
    return postRequest('/whitelist/delByIds', params)
}