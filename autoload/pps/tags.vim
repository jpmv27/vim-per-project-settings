function! s:tags_file_path(name) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    if !isdirectory(dir)
        return ''
    endif

    return dir . '/' . a:name
endfunction

function! s:prepend_tags(name) abort
    if empty(split(&tags, ',', 1))[0]
        execute 'setlocal tags=' . a:name . &tags
    else
        execute 'setlocal tags=' . a:name . ',' . &tags
    endif
endfunction

function! pps#tags#init() abort
    let s:default_tags = &tags
endfunction

function! pps#tags#reset() abort
    execute 'setlocal tags=' . s:default_tags
endfunction

function! pps#tags#enable(name) abort
    let tags = s:tags_file_path(a:name)

    if tags ==# ''
        echo 'Could not enable tags per-project settings'
        return
    endif

    call s:prepend_tags(tags)
endfunction

function! pps#tags#disable() abort
    if !empty(split(&tags, ',', 1)[0])
        call s:prepend_tags('')
    endif
endfunction

function! pps#tags#ref_only(name) abort
    " Need comma even if tags currently empty
    execute 'setlocal tags=' . &tags . ',' . a:name
endfunction
