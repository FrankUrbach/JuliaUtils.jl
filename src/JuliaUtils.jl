module JuliaUtils

using DataFrames

export diff_functions_two_files

"""
```julia
function diff_functions_two_files(file_main::String, file_to_proof::String, col_name_main::String, col_name_to_proof::String)
```
    This function is supposed to get the function from file_main and check if the function name also appears in the second file. 
    If this is not the case, these functions will be displayed in the result.
"""
function diff_functions_two_files(file_main::String, file_to_proof::String, col_name_main::String, col_name_to_proof::String)
    
    fileTextMain =open(f->read(f,String),file_main)
    fileTextToProof =open(f->read(f,String),file_to_proof)

    allMatches_Main = findall(r"(?i)(?s)function +(\w+\.|\w+)+?[a-zA-Z0-9_]*\((([^()])|(\([^()]*\)))*\)",fileTextMain)
    allMatches_to_proof = findall(r"(?i)(?s)function +(\w+\.|\w+)+?[a-zA-Z0-9_]*\((([^()])|(\([^()]*\)))*\)",fileTextToProof)


    eachFunctionPostgres = map(x->SubString(fileTextMain,x),allMatches_Main)
    eachFunctionOracle = map(x->SubString(fileTextToProof,x),allMatches_to_proof)      

    main_FunctionCalls = [string(first(split(item,"("))) for item in eachFunctionOracle]
    to_proof_FunctionCalls= [string(first(split(item,"("))) for item in eachFunctionPostgres]


    overview = Matrix{Any}(missing,length(to_proof_FunctionCalls),2)

    for i in 1:length(to_proof_FunctionCalls)
        overview[i,1] = to_proof_FunctionCalls[i]
        if findfirst(x->to_proof_FunctionCalls[i] == x,main_FunctionCalls) !== nothing
            overview[i,2] = main_FunctionCalls[findfirst(x->to_proof_FunctionCalls[i] == x,main_FunctionCalls)]
        end
    end

    df = DataFrame(overview,[Symbol(col_name_main), Symbol(col_name_to_proof)])

    missedFunctions = filter(x->x[Symbol(col_name_main)] === missing,df)

end #end diff_functions_two_files


end
