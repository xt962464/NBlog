
export function removeHTMLTag(str) {
    str = str.replace(/<\/?[^>]*>/g, '') // 去除HTML tag
    str = str.replace(/[ | ]*\n/g, '\n') // 去除行尾空白
    str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
    str = str.replace(/ /ig, '') // 去掉
    const arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' } // 转义符换成普通字符
    str = str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t] })
    return str
}