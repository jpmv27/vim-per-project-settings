function! pps#init(dir) abort
    call pps#utils#set_base_dir(a:dir)
    call pps#spell#init()

    augroup pps
        autocmd!
        autocmd BufEnter * call pps#reset()
    augroup END
endfunction

function! pps#reset() abort
    call pps#spell#reset()
endfunction

function! pps#callback(project, is_leaf) abort
    let b:pps_project_name = a:project
    let b:pps_is_leaf = a:is_leaf

    call pps#vimrc#apply()
endfunction

function! pps#dir() abort
    return pps#utils#get_project_dir(1)
endfunction

function! pps#is_project(name) abort
    if !exists('b:pps_project_name')
        return 0
    endif

    return a:name ==# b:pps_project_name
endfunction

function! pps#is_leaf() abort
    if !exists('b:pps_is_leaf')
        return 0
    endif

    return b:pps_is_leaf
endfunction

