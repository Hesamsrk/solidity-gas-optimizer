from slither.slither import Slither

def detect_struct_packing(slither:Slither):
    """
    Detects struct packing inefficiencies in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        for structure in contract.structures:     
                result = {"analysis_type": "detect_struct_packing","contract_name":contract.name, "structure_name":structure.name}
                current_field_order  = []
                if len(structure.elems.items()) == 1:
                     result["message"] = "Only one element - no reorder required"
                     results.append(result)
                     break
                for key, value in structure.elems.items():
                    var_type = value.type
                    current_field_order.append({"field_name":key,"field_type":var_type.name,"field_size_bytes":var_type.size//8})
                result["current_field_order"] = current_field_order
                result["recommended_field_order"] = sorted(current_field_order, key=lambda x: x['field_size_bytes'], reverse=True)
                results.append(result)
                             
    if len(results)==0:
         results.append({
                 "analysis_type": "detect_struct_packing",
                 "message": f"No structures found in contract {contract.name}"
            })            
                
                    
                

    return results




