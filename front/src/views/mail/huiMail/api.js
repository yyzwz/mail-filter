import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getMailArchivesOne = (params) => {
    return getRequest('/mailArchives/getOne', params)
}
export const getMailArchivesList = (params) => {
    return getRequest('/mailArchives/getByLaJiPage', params)
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
export const getAllMailFile = (params) => {
    return getRequest('/mailFile/getAll', params)
}
export const deleteOnUser = (params) => {
    return postRequest('/mailArchives/deleteOnUser', params)
}