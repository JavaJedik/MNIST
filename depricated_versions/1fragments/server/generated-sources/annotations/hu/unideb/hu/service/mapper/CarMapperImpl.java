package hu.unideb.hu.service.mapper;

import hu.unideb.hu.dto.CarDto;
import hu.unideb.hu.model.Car;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.processing.Generated;
import org.springframework.stereotype.Component;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2023-10-19T10:40:18+0200",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 17.0.8.1 (Private Build)"
)
@Component
public class CarMapperImpl implements CarMapper {

    @Override
    public CarDto carEntityToDto(Car c) {
        if ( c == null ) {
            return null;
        }

        CarDto carDto = new CarDto();

        carDto.setId( c.getId() );
        carDto.setRendszam( c.getRendszam() );
        carDto.setSzin( c.getSzin() );

        return carDto;
    }

    @Override
    public List<CarDto> carEntityListToDtoList(List<Car> c) {
        if ( c == null ) {
            return null;
        }

        List<CarDto> list = new ArrayList<CarDto>( c.size() );
        for ( Car car : c ) {
            list.add( carEntityToDto( car ) );
        }

        return list;
    }

    @Override
    public Car carDtoToEntity(CarDto dto) {
        if ( dto == null ) {
            return null;
        }

        Car car = new Car();

        car.setId( dto.getId() );
        car.setRendszam( dto.getRendszam() );
        car.setSzin( dto.getSzin() );

        return car;
    }

    @Override
    public List<Car> carDtoListToEntityList(List<CarDto> dtoList) {
        if ( dtoList == null ) {
            return null;
        }

        List<Car> list = new ArrayList<Car>( dtoList.size() );
        for ( CarDto carDto : dtoList ) {
            list.add( carDtoToEntity( carDto ) );
        }

        return list;
    }
}
