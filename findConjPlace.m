function conj_place = findConjPlace(ind,ydata,p,z,flag)
conj_place = 0;
switch flag{1}
    case pole
        for i = length(p)
            if ydata(ind) == - imag(p(i))
                conj_place = i;
            end
        end
    case zero
        for i = length(z)
            if ydata(ind) == - imag(z(i))
                conj_place = i;
            end
        end
end
end