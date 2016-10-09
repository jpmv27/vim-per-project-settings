function! pps#utils#set_base_dir(dir) abort
    let s:base_dir = a:dir
endfunction

function! pps#utils#get_project_dir(quiet) abort
    if !exists('b:pps_project_name')
        if !a:quiet
            echo 'Not in a project'
        endif

        return ''
    endif

    if !exists('s:base_dir')
        if !a:quiet
            echo 'You must call PpsInit()'
        endif

        return ''
    endif

    return resolve(fnameescape(expand(s:base_dir) . '/' . b:pps_project_name))
endfunction

function! pps#utils#make_dir(...) abort
    let dir = pps#utils#get_project_dir(0)
    if dir ==# ''
        return
    endif

    if a:0 == 0
        if !isdirectory(dir)
            call mkdir(dir, 'p')
            echo 'Project directory ' . dir . ' created'
        else
            echo 'Project directory ' . dir . ' already exists'
        endif
    else
        if !isdirectory(dir)
            echo 'You must create the project directory first'
            return
        endif

        let dir = dir . '/' . a:1

        if !isdirectory(dir)
            call mkdir(dir, 'p')
            echo 'Directory ' . dir . ' created'
        else
            echo 'Directory ' . dir . ' already exists'
        endif
    endif
endfunction

function! pps#utils#remove_dir(...) abort
    let dir = pps#utils#get_project_dir(0)
    if dir ==# ''
        return
    endif

    if a:0 == 0
        if isdirectory(dir)
            call delete(dir, 'rf')
            echo 'Project directory ' . dir . ' removed'
        else
            echo 'Project directory ' . dir . " doesn't exist"
        endif
    else
        if !isdirectory(dir)
            echo 'No project directory'
            return
        endif

        let dir = dir . '/' . a:1

        if isdirectory(dir)
            call delete(dir, 'rf')
            echo 'Directory ' . dir . ' removed'
        else
            echo 'Directory ' . dir . " doesn't exist"
        endif
    endif
endfunction

function! pps#utils#edit_file(...) abort
    let dir = pps#utils#get_project_dir(0)
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'You must create the project directory first'
        return
    endif

    let file = dir
    if a:0
        let file = file . '/' . a:1
    endif

    execute 'split ' . file
endfunction

function! pps#utils#remove_file(...) abort
    let dir = pps#utils#get_project_dir(0)
    if dir ==# ''
        return
    endif

    if !isdirectory(dir)
        echo 'No project directory'
        return
    endif

    let file = dir . '/' . a:1

    if filereadable(file)
        call delete(file)
        echo 'File ' . file . ' deleted'
    else
        echo 'File ' . file . " doesn't exist"
    endif
endfunction

function! pps#utils#dir_complete(ArgLead, CmdLine, CursorPos) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    return system('find ' . dir . ' -mindepth 1 -maxdepth 1 -type d -printf "%P\n" | sort')
endfunction

function! pps#utils#file_complete(ArgLead, CmdLine, CursorPos) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    return system('find ' . dir . ' -maxdepth 1 -type f -printf "%P\n" | sort')
endfunction

