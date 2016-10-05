function! pps#utils#get_project_dir() abort
    if !exists('b:pps_project_name')
        echo 'Not in a project'
        return ''
    endif

    if !exists('g:pps_base_dir')
        echo 'You must define g:pps_base_dir'
        return ''
    endif

    return resolve(fnameescape(expand(g:pps_base_dir) . '/' . b:pps_project_name))
endfunction

function! pps#utils#apply_settings() abort
    let active = (pps#utils#get_project_dir() !=# '')

    call pps#vimrc#configure(active)
    call pps#tags#configure(active)
    call pps#spell#configure(active)
endfunction

function! pps#utils#make_project_dir() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        call mkdir(dir, 'p')
        call pps#utils#apply_settings()
        echo 'Directory ' . dir . ' created'
    else
        echo 'Directory ' . dir . ' already exists'
    endif
endfunction

function! pps#utils#remove_project_dir() abort
    let dir = pps#utils#get_project_dir()
    if dir ==# ''
        return
    endif

    if isdirectory(dir)
        call delete(dir, 'rf')
        call pps#utils#apply_settings()
        echo 'Directory ' . dir . ' removed'
    else
        echo 'Directory ' . dir . " doesn't exist"
    endif
endfunction

