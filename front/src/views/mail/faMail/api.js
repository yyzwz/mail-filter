import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getMailArchivesOne = (params) => {
    return getRequest('/mailArchives/getOne', params)
}
export const getMailArchivesList = (params) => {
    return getRequest('/mailArchives/getByFaPage', params)
}
export const getMailArchivesCount = (params) => {
    return getRequest('/mailArchives/count', params)
}
export const addMailArchives = (params) => {
    return postRequest('/mailArchives/insert', params)
}
export const editMailArchives = (params) => {
    return postRequest('/mailArchives/update', params)
}
export const addOrEditMailArchives = (params) => {
    return postRequest('/mailArchives/insertOrUpdate', params)
}
export const deleteMailArchives = (params) => {
    return postRequest('/mailArchives/delByIds', params)
}
export const getAllMailUser = (params) => {
    return getRequest('/user/getAllMailUser', params)
}
export const saveCao = (params) => {
    return postRequest('/mailArchives/saveCao', params)
}
export const editCao = (params) => {
    return postRequest('/mailArchives/editCao', params)
}
export const addFile = (params) => {
    return getRequest('/mailFile/addFile', params)
}
export const getAllMailFile = (params) => {
    return getRequest('/mailFile/getAll', params)
}
export const deleteMailFile = (params) => {
    return postRequest('/mailFile/delByIds', params)
}