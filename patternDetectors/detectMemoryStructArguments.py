from slither.slither import Slither


def detect_memory_struct_arguments(slither: Slither):
    """
    Detects struct arguments using memory and asks them to use calldata instead.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_memory_struct_arguments", "contract_name":contract.name}
        memory_struct_arguments = []
        for f in contract.functions:
            params = [p for p in f.parameters if p.location == "memory" and not p.is_scalar]
            print(params)
            for p in params:
                memory_struct_arguments.append({"function_name":f.name,"parameter_name":p.name,"parameter_type":str(p.type)})
        if len(memory_struct_arguments)==0:
            result["message"] = "No struct arguments used memory - no optimization required"
            continue
        result["memory_struct_arguments"] = memory_struct_arguments
        result["message"] = "Struct arguments should use 'calldata' instead of 'memory' for better gas optimization."
        results.append(result)

    return results