from slither.slither import Slither


def detect_dynamic_size_arrays(slither: Slither):
    """
    Detects dynamic size array inefficiencies in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_dynamic_size_arrays", "contract_name":contract.name}
        dynamic_arrays = [i for i in contract.variables if i.type.is_dynamic and "[]" in str(i.type)]
        if len(dynamic_arrays) == 0:
            result["message"] = "No dynamic arrays - no optimization required"
            results.append(result)
            break
       
        result["dynamic_arrays"] = [{"arr_name":var.name,"arr_type":str(var.type)} for var in dynamic_arrays]
        result["message"] = "Consider using statically sized arrays instead of dynamic arrays for the array variables, if possible - example: uint256[] => uint256[10]"
        results.append(result)
                        
    return results