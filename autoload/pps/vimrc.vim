function! s:vimrc_file_path() abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    return dir . '/vimrc'
endfunction

function! pps#vimrc#apply() abort
    let vimrc = s:vimrc_file_path()
    if (vimrc ==# '') || !filereadable(vimrc)
        return
    endif

    execute 'source' vimrc
endfunction

function! pps#vimrc#edit() abort
    let dir = pps#utils#get_project_dir(0)
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'You must create the project directory first'
        return
    endif

    let vimrc = s:vimrc_file_path()
    if vimrc ==# ''
        return
    endif

    execute 'split ' . vimrc
endfunction

