import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getKeyArchivesOne = (params) => {
    return getRequest('/keyArchives/getOne', params)
}
export const getKeyArchivesList = (params) => {
    return getRequest('/keyArchives/getByPage', params)
}
export const getKeyArchivesCount = (params) => {
    return getRequest('/keyArchives/count', params)
}
export const addKeyArchives = (params) => {
    return postRequest('/keyArchives/insert', params)
}
export const editKeyArchives = (params) => {
    return postRequest('/keyArchives/update', params)
}
export const addOrEditKeyArchives = (params) => {
    return postRequest('/keyArchives/insertOrUpdate', params)
}
export const deleteKeyArchives = (params) => {
    return postRequest('/keyArchives/delByIds', params)
}